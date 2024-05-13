<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="test.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
     <link rel="stylesheet" href="blah/petals.css">
  <style>
        body {
            background-color: #ffefef; /* Light pink background color */
            font-family: Arial, sans-serif;
            text-align:center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color:  #FFC0CB;
        }
        tr{
            background-color: #ffeaeeb8;
        }
        tr:hover {
            background-color: #f77fa1ad;
        }
        /* Add styles for the dialog */
        #dialog, #editDialog, #deleteDialog {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #FFC0CB; /* Light pink background color */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            display: none;
            max-width: 400px; /* Limit dialog width */
        }
        /* Add styles for the overlay */
        #overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
            display: none;
        }
        /* Add styles for the buttons */
        button {
            background-color: #FFC0CB; /* Light pink background color */
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            transition-duration: 0.4s;
            border-radius:10px;
        }
        button:hover {
            background-color: #ffffff; /* Darker pink when hovered */
            color:  #f77fa1;
        }
        .Login-Rgister-label{
        	color: #ffffff;
        }
        .AddButton-user{
            display:flex;
            justify-content:flex-end;
        }
        .delete-button-users{
            color: white;
            background-color:red;
        }
        .delete-button-users:hover{
            color: red;
            background-color:#000000;
        }
        /* Styles for dialog form elements */
        .register-form-container, .edit-form-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .register-form-container input, .edit-form-container input {
            margin: 10px 0;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            font-size: 16px;
        }
        .register-form-container button, .edit-form-container button {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #f77fa1;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .register-form-container button:hover, .edit-form-container button:hover {
            background-color: #ffffff;
            color:#f77fa1;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
     <div id="blossom_container"></div>

     <script src="js/petals.js"></script>
    <h2>User List</h2>
    <div class="AddButton-user">
     <button onclick="openDialog()">Add User</button>
    </div>
    <table>
        <tr>
            <th>Email</th>
            <th>Contact Number</th>
            <th>Address</th>
            <th>Password</th>
            <th>Actions</th>
        </tr>
        <%
            List<User> userList = (List<User>) request.getAttribute("userList");
            for (User user : userList) {
        %>
        <tr>
            <td><%= user.getEmail() %></td>
            <td><%= user.getContactNumber() %></td>
            <td><%= user.getAddress() %></td>
            <td><%= user.getPassword() %></td>
            <td style="display: flex; justify-content: center;">
                <button onclick="openEditDialog('<%= user.getEmail() %>', '<%= user.getContactNumber() %>', '<%= user.getAddress() %>', '<%= user.getPassword() %>')">Edit</button>
				<button class="delete-button-users" onclick="openDeleteDialog('<%= user.getEmail() %>')">Delete</button>

            </td>
        </tr>
        <%
            }
        %>
    </table>
    <div id="overlay"></div>
    <div id="dialog" style="display: none;">
          <form action="RegistrationServlet" method="POST">
            <div class="register-form-container">
                 <label class="Login-Rgister-label">Email:</label>
                <input class="input-text" type="email" name="email" placeholder="Email address" required onchange="validatemail()">
                <label class="Login-Rgister-label">Contact Number:</label>
                <input class="input-text" type="text" name="contactNumber" placeholder="Contact number" required>
                <label class="Login-Rgister-label">Address:</label>
                <input class="input-text" type="text" name="address" placeholder="Address" required>
                <label class="Login-Rgister-label">Password:</label>
                <input class="input-text" type="password" name="password" id="password" placeholder="Password" required onchange="validatePass()">
                <div>
	                  <button class="edit-button-user" type="submit">Register</button>
	                  <button class="delete-button-users" type="button" onclick="closeDialog()">Close</button>
	              </div>
            </div>
        </form>
    </div>
    <div id="editDialog" style="display: none;">
        <form action="UpdateUserServlet" method="POST">
          <div class="edit-form-container">
                <label class="Login-Rgister-label">Email:</label>
                <input class="input-text" type="email" name="email" placeholder="Email address" required>
                <label class="Login-Rgister-label">Contact Number:</label>
                <input class="input-text" type="text" name="contactNumber" placeholder="Contact number" required>
                <label class="Login-Rgister-label">Address:</label>
                <input class="input-text" type="text" name="address" placeholder="Address" required>
                <label class="Login-Rgister-label">Password:</label>
                <input class="input-text" type="text" name="password" id="password" placeholder="Password" required>
                <div>
                    <button class="edit-button-user" type="submit">Update</button>
                    <button class="delete-button-users" type="button" onclick="closeEditDialog()">Cancel</button>
                </div>
            </div>
        </form>
    </div>
    <div id="deleteDialog" style="display: none;">
	    <form action="DeleteUserServlet" method="POST">
	        <div class="edit-form-container">
	            <p>Are you sure you want to delete this user?</p>
	            
				<input type="hidden" name="email" id="deleteEmail" placeholder="Email address"  required>
	            <div>
	                <button class="delete-button-users" type="submit">Yes</button>
	                <button class="edit-button-user" type="button" onclick="closeDeleteDialog()">No</button>
	            </div>
	        </div>
	    </form>
	</div>
    <script>
        function openDialog() {
            document.getElementById('dialog').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('editDialog').style.display = 'none';
            document.getElementById('deleteDialog').style.display = 'none';// Hide edit dialog if open
        }
        function closeDialog() {
            document.getElementById('dialog').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }
        function openEditDialog(email, contactNumber, address, password) {
            document.getElementById('editDialog').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('dialog').style.display = 'none';
            document.getElementById('deleteDialog').style.display = 'none';// Hide edit dialog if open
            // Populate fields with user data
            document.getElementsByName('email')[1].value = email;
            document.getElementsByName('contactNumber')[1].value = contactNumber;
            document.getElementsByName('address')[1].value = address;
            document.getElementsByName('password')[1].value = password;
        }
        function closeEditDialog() {
            document.getElementById('editDialog').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }
        
        function openDeleteDialog(email) {
            document.getElementById('deleteDialog').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('dialog').style.display = 'none';
            document.getElementById('editDialog').style.display = 'none';
            
            document.getElementById('deleteEmail').value = email;
        }

        function closeDeleteDialog() {
            document.getElementById('deleteDialog').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }
    </script>

</body>
</html>
