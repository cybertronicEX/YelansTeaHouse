<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="blah/navbar.css">

<nav>

    <div class="logo">
        <img src="imgs/logo.png" alt="Logo">
            <div class="logotext">
        		<img src="imgs/logotext.png" alt="Logotext">
    		</div>
    </div>

    <ul>
        <li><a href="home.jsp">Home</a></li>
        <%-- Show "Users" link only if user ID is 1 --%>
        <% Integer userID = (Integer) session.getAttribute("id"); %>
        <% if (userID != null && userID == 1) { %>
            <li><a href="UserServlet">Users</a></li>
        <% } %>
        <li><a href="ProductServlet">Products</a></li>
        
        <%-- Show user email if available in session --%>
        <% String userEmail = (String) session.getAttribute("email"); %>
        <% if (userEmail != null) { %>
            <li><%= userEmail %></li>
        <% } %> 
        <li><a href="LogoutServlet">Logout</a></li>
    </ul>
</nav>
