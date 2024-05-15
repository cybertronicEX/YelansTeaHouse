<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="test.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart</title>
    <link rel="stylesheet" type="text/css" href="blah/css/cart.css">
    <link rel="stylesheet" href="blah/petals.css">
</head>
<body>

<%@ include file="navbar.jsp" %>
    
    <div id="blossom_container"></div>
    <script src="js/petals.js"></script>
    
    <h1>Shopping Cart</h1>
    
    <div class="cart-items">
        <table>
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
            <%-- Retrieve cart items and display them --%>
            <%
                Object cartItemsObj = request.getAttribute("cartItems");
                if (cartItemsObj != null && cartItemsObj instanceof List) {
                    List<?> cartItems = (List<?>) cartItemsObj;
                    for (Object obj : cartItems) {
                        if (obj instanceof CartItem) {
                            CartItem item = (CartItem) obj;
            %>
                            <tr>
                                <td><%= item.getProduct().getItemName() %></td>
                                <td><%= item.getQuantity() %></td>
                                <td>$<%= item.getProduct().getPrice() %></td>
                                <td>$<%= item.getQuantity() * item.getProduct().getPrice() %></td>
                            </tr>
            <%          }
                    }
                } else {
                    // Handle the case where the attribute is null or not a List<CartItem>
                    out.println("Error: Cart items could not be retrieved.");
                }
            %>
        </table>
    </div>

    <div class="cart-actions">
        <a href="home.jsp">Proceed to Checkout</a>
    </div>
</body>
</html>
