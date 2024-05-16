<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>Session Details</title>
    <link rel="stylesheet" href="blah/petals.css">
    <link rel="stylesheet" href="blah/css/users.css">

</head>
<body>
    <%@ include file="navbar.jsp" %>
     <div id="blossom_container"></div>
     <script src="js/petals.js"></script>
    <h1 style="color: #ff85aa;">Session Details</h1>
 
    <%
        // Get the session
        HttpSession session1 = request.getSession(false); // Don't create a new session if it doesn't exist
        
        if (session1 != null) {
        	 String email = (String) session.getAttribute("email");
        	 Integer id = (Integer) session.getAttribute("id");
    %>		
    		<p>Id: <%= id %></p>
    		<p>Email: <%= email %></p>
            <p>Session ID: <%= session1.getId() %></p>
            <p>Creation Time: <%= new java.util.Date(session1.getCreationTime()) %></p>
            <p>Last Accessed Time: <%= new java.util.Date(session1.getLastAccessedTime()) %></p>
    <%
        } else {
    %>
            <p>No session found. Please create a session.</p>
    <%
        }
    %>
</body>
</html>
