<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="test.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products</title>
    <link rel="stylesheet" type="text/css" href="blah/css/products.css">
    <link rel="stylesheet" href="blah/petals.css">
</head>
<body>

    <%@ include file="navbar.jsp" %>
    
    <div id="blossom_container"></div>
    <script src="js/petals.js"></script>
    
    <!-- Search bar -->
    <div class="search-bar">
        <input type="text" id="searchInput" placeholder="  Search products...">
        <button type="button" id="searchButton">Search</button>
    </div>
    
    
    <!-- Filters -->
    <div class="filters">
    
    	<!-- Add Products Button -->
    	<%
    	Integer userId = (Integer) session.getAttribute("id");
    	if (userId != null && userId == 1) {
    	%>
    	    <button class="add-product-button" onclick="openAddProductDialog()">Add Product</button>
    	<%
    	}
    	%>
    	
        <!-- Drop down for price -->
        <select name="price">
            <option value="">Filter by Price</option>
            <!-- Add options dynamically if needed -->
        </select>
        
		<!-- Drop down for brandName -->
		<select id="brandNameFilter" name="brandName" onchange="filterProductsByBrand()">
		    <option value="">Filter by Brand Name</option>
		    <!-- Populate drop down with brand names from the database -->
		    <% 
		    List<String> brandList = (List<String>) request.getAttribute("brandList");
		    if (brandList != null) {
		        for (String brand : brandList) {
		    %>
		    <option value="<%= brand %>"><%= brand %></option>
		    <% 
		        }
		    }
		    %>
		</select>
		        
        <!-- Drop down for weight -->
        <select name="weight">
            <option value="">Filter by Weight</option>
            <!-- Add options dynamically if needed -->
        </select>
        
    </div>
    
    <!-- Product grid -->
	<div class="product-grid">
	    <%
	    List<Product> productList = (List<Product>) request.getAttribute("productList");
	    for (Product product : productList) {
	    %>
	    
	   	<form id="deleteProductForm_<%= product.getItemNo() %>" action="DeleteProductServlet" method="POST">
    	<input type="hidden" name="itemName" value="<%= product.getItemName() %>">
	    <div class="product-card" onclick="openProductPopup('<%= product.getItemName() %>', <%= product.getPrice() %>, '<%= product.getBrandName() %>', <%= product.getWeight() %>, '<%= product.getNutrition() %>', '<%= product.getImageUrl() %>')">
	        <%
	        if (userId != null && userId == 1) {
	        %>
	        <div class="icon-container">
				<img class="edit-icon" src="<%= request.getContextPath() %>/svg/edit.svg" alt="Edit" onclick="openEditProductDialog('<%= product.getItemName() %>', '<%= product.getPrice() %>', '<%= product.getBrandName() %>', '<%= product.getWeight() %>', '<%= product.getNutrition() %>', '<%= product.getImageUrl() %>', event)">
	            <img class="delete-icon" src="<%= request.getContextPath() %>/svg/delete.svg" alt="Delete" onclick="confirmDelete('<%= product.getItemName() %>', '<%= product.getItemNo() %>')">
	        </div>
	        <%
	        }
	        %>
	        <img src="<%= product.getImageUrl() %>" alt="<%= product.getItemName() %>">
	        <div class="product-details">
	            <p class="item-name"><%= product.getItemName() %></p>
	            <p class="price">Rs. <%= product.getPrice() %></p>
	            <button class="add-to-cart-button">Add to Cart</button>
	        </div>
	    </div>
	    </form>
	    <%
	    }
	    %>
	</div>
	
	<!-- Product Popup -->
	<div id="productPopup" class="popup product-popup" style="display: none;">
	  <div class="popupcontent" id="popupContent">
	      <label for="show_imageUrl"></label>
	      <div id="show_imageUrl"></div>
	      
	      	<div class="popupcontent2">
		 		<label for="show_itemName"></label>
		     	<div class="show-item-name "id="show_itemName"></div>
		     	<label for="show_price"></label>
		     	<div class="show-item-price" id="show_price"></div>
		     	<label for="show_brandName"></label>
		     	<div class="show-brand-name" id="show_brandName"></div>
		     	<label for="show_weight"></label>
		     	<div class="show-weight" id="show_weight"></div>
		     	<label for="show_nutrition"></label>
		     	<div class="show-nutrition" id="show_nutrition"></div>
		     	
		     	<button class="close-product-popup" onclick="closeProductPopup()">Close</button>
		     	
		  	</div>
	  </div> 
	</div>


    <!-- Add Product Popup -->
    <div id="addProductPopup" class="popup" style="display: none;">
        <form id="addProductForm" action="AddProductServlet" method="POST" onsubmit="return validateAddProductForm()">
 			<label for="add_itemName">Item Name:</label>
            <input type="text" id="add_itemName" name="itemName" required>
            <label for="add_price">Price:</label>
            <input type="text" id="add_price" name="price" required>
            <label for="add_brandName">Brand Name:</label>
            <input type="text" id="add_brandName" name="brandName" required>
            <label for="add_weight">Weight:</label>
            <input type="text" id="add_weight" name="weight" required>
            <label for="add_nutrition">Nutrition:</label>
            <input type="text" id="add_nutrition" name="nutrition" required>
            <label for="add_imageUrl">Image URL:</label>
            <input type="text" id="add_imageUrl" name="imageUrl" required>
            <button type="submit">Add Product</button>
            
            <button type="button" onclick="closeAddProductDialog()">Close</button>
            
        </form>
    </div>
    
    <!-- Edit Product Popup -->
    <div id="editProductPopup" class="popup" style="display: none;">
        <form id="editProductForm" action="UpdateProductServlet" method="POST" onsubmit="return validateEditProductForm()">
            <label for="edit_itemName">Item Name:</label>
            <input type="text" id="edit_itemName" name="itemName" required>
            <label for="edit_price">Price:</label>
            <input type="text" id="edit_price" name="price" required>
            <label for="edit_brandName">Brand Name:</label>
            <input type="text" id="edit_brandName" name="brandName" required>
            <label for="edit_weight">Weight:</label>
            <input type="text" id="edit_weight" name="weight" required>
            <label for="edit_nutrition">Nutrition:</label>
            <input type="text" id="edit_nutrition" name="nutrition" required>
            <label for="edit_imageUrl">Image URL:</label>
            <input type="text" id="edit_imageUrl" name="imageUrl" required>
            <button type="submit">Update Product</button>
            
            <button type="button" class="close-button" onclick="event.preventDefault(); closeEditProductDialog();">Close</button>
            
        </form>
    </div>

    <!-- Overlay -->
    <div id="overlay" style="display: none;"></div>

    <script>
        function openProductPopup(itemName, price, brandName, weight, nutrition, imageUrl) {
            // Set each product detail individually in the popup content
            document.getElementById('show_imageUrl').innerHTML = '<img src="' + imageUrl + '" alt="' + itemName + '">';
            document.getElementById('show_itemName').innerHTML = itemName;
            document.getElementById('show_price').innerHTML = 'Rs. ' + price;
            document.getElementById('show_brandName').innerHTML = brandName;
            document.getElementById('show_weight').innerHTML = weight + 'g';
            document.getElementById('show_nutrition').innerHTML = nutrition;

            // Show the popup
            document.getElementById('productPopup').style.display = 'block';

            // Show overlay
            document.getElementById('overlay').style.display = 'block';
        }

        function closeProductPopup() {
            // Hide the popup
            document.getElementById('productPopup').style.display = 'none';

            // Hide overlay
            document.getElementById('overlay').style.display = 'none';
        }

        // Function to open Add Product dialog
        function openAddProductDialog() {
            document.getElementById('addProductPopup').style.display = 'block';
            toggleOverlay();
        }

        // Function to close Add Product dialog
        function closeAddProductDialog() {
            document.getElementById('addProductPopup').style.display = 'none';
            toggleOverlay();
        }

        // Function to open Edit Product dialog
        function openEditProductDialog(itemName, price, brandName, weight, nutrition, imageUrl, event) {
            // Stop event propagation
            if (event) {
                event.stopPropagation();
            }

            document.getElementById('editProductPopup').style.display = 'block';
            document.getElementById('addProductPopup').style.display = 'none'; // Hide add product popup if open
            toggleOverlay();
            // Populate fields with product data
            document.getElementById('edit_itemName').value = itemName;
            document.getElementById('edit_price').value = price;
            document.getElementById('edit_brandName').value = brandName;
            document.getElementById('edit_weight').value = weight;
            document.getElementById('edit_nutrition').value = nutrition;
            document.getElementById('edit_imageUrl').value = imageUrl;
        }

        // Function to close Edit Product dialog
        function closeEditProductDialog() {
            document.getElementById('editProductPopup').style.display = 'none';
            toggleOverlay();
        }

        // Function to confirm product deletion
        function confirmDelete(itemName, productId) {
            if (confirm("Are you sure you want to delete the product '" + itemName + "'?")) {
                // If user confirms, submit the form to delete the product
                document.getElementById('deleteProductForm_' + productId).submit();
            }
        }

        // Function to toggle overlay visibility
        function toggleOverlay() {
            var overlay = document.getElementById('overlay');
            overlay.style.display = (overlay.style.display === 'block') ? 'none' : 'block';
        }
        
        // Search functionality
        document.getElementById("searchButton").addEventListener("click", function() {
            var searchQuery = document.getElementById("searchInput").value;
            // Send the search query to the server-side servlet for processing
            searchProducts(searchQuery);
        });

        // Allow pressing enter to trigger search
        document.getElementById("searchInput").addEventListener("keyup", function(event) {
            if (event.keyCode === 13) {
                event.preventDefault();
                document.getElementById("searchButton").click();
            }
        });

        function searchProducts(query) {
            // Send an AJAX request to the server
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        // On successful response, replace the product grid with updated data
                        document.querySelector('.product-grid').innerHTML = xhr.responseText;
                    } else {
                        // Handle errors if any
                        console.error('Search request failed:', xhr.status);
                    }
                }
            };
            xhr.open('GET', 'SearchProductServlet?query=' + encodeURIComponent(query), true);
            xhr.send();
        }
        
        // Function to filter products based on brand name
        function filterProductsByBrand() {
            var brandName = document.getElementById("brandNameFilter").value;
            // Send an AJAX request to the server to filter products by brand name
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        // On successful response, replace the product grid with updated data
                        document.querySelector('.product-grid').innerHTML = xhr.responseText;
                    } else {
                        // Handle errors if any
                        console.error('Filter request failed:', xhr.status);
                    }
                }
            };
            xhr.open('GET', 'FilterProductServlet?brandName=' + encodeURIComponent(brandName), true);
            xhr.send();
        }

        // Validate Add Product Form
        function validateAddProductForm() {
            return validateProductForm('add_itemName', 'add_price', 'add_brandName', 'add_weight', 'add_nutrition', 'add_imageUrl');
        }

        // Validate Edit Product Form
        function validateEditProductForm() {
            return validateProductForm('edit_itemName', 'edit_price', 'edit_brandName', 'edit_weight', 'edit_nutrition', 'edit_imageUrl');
        }

        // Common validation function for Add and Edit Product Forms
        function validateProductForm(itemNameId, priceId, brandNameId, weightId, nutritionId, imageUrlId) {
            var itemName = document.getElementById(itemNameId).value;
            var price = document.getElementById(priceId).value;
            var brandName = document.getElementById(brandNameId).value;
            var weight = document.getElementById(weightId).value;
            var nutrition = document.getElementById(nutritionId).value;
            var imageUrl = document.getElementById(imageUrlId).value;

            if (!itemName || !price || !brandName || !weight || !nutrition || !imageUrl) {
                alert('All fields are required.');
                return false;
            }

            if (nutrition.includes("'")) {
                alert('The Nutrition field cannot contain the symbol \'.');
                return false;
            }

            if (isNaN(price)) {
                alert('The Price field must contain only numbers.');
                return false;
            }

            if (isNaN(weight)) {
                alert('The Weight field must contain only numbers.');
                return false;
            }

            return true;
        }

        // Prevent non-numeric input in Price and Weight fields
        document.getElementById('add_price').addEventListener('keypress', function(e) {
            if (isNaN(String.fromCharCode(e.which))) {
                e.preventDefault();
            }
        });
        document.getElementById('edit_price').addEventListener('keypress', function(e) {
            if (isNaN(String.fromCharCode(e.which))) {
                e.preventDefault();
            }
        });
        document.getElementById('add_weight').addEventListener('keypress', function(e) {
            if (isNaN(String.fromCharCode(e.which))) {
                e.preventDefault();
            }
        });
        document.getElementById('edit_weight').addEventListener('keypress', function(e) {
            if (isNaN(String.fromCharCode(e.which))) {
                e.preventDefault();
            }
        });

    </script>

</body>
</html>
