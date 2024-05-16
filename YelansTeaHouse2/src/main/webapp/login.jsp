<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" href="blah/style.css">
        <link rel="stylesheet" href="blah/petals.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css">
  		<!-- Bootstrap -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>	
</head>
<body>
 <div class="LoginMainContainer">
  <div id="blossom_container"></div>

     <script src="js/petals.js"></script>
    
      	<div class="topbar d-flex flex-row align-items-center">
			<img class="img-contain p-3" src="imgs/logo.png">
		</div>
		<div class="tree_container">
			<img class="img-contain p-3" src="imgs/tree.png">
		</div>
        <div class="form-wrap">
               <div  class="header">
                   <!--title-->
                   <div>
                      <img class="img-contain1 p-3" src="imgs/pinklogo.png">
                   </div>
                   <!--end title-->
               </div>
                <!--form-->
	           <form action="LoginServlet" method="POST">
		            <div class="login-form-container">
		            	<div class="login-form-input-holder">
	                        <label class="login-form-label">E-mail:</label>
	                        <input class="input-text" type="email" name="email" placeholder="Email address" required onchange="validatemail()">
	                        <label class="login-form-label">password:</label>
	                        <input class="input-text" type="password" name="password" id="password" placeholder="Password" required onchange="validatePass()">
                    	</div>
                        <button class="btn1 btn-loggin" type = "submit">Login</button>
	                </div>
                </form>
                   	<div class="login-sign-up">
                        <p class="login-text">Don't have an account?</p>
                        <a  class="sign-up-link"  href="register.jsp">Sign up</a>
                    </div>
                </div>
        
         </div>
          <script>
        function togglePasswordVisibility() {
            var passwordField = document.getElementById("password");
            var eyeIcon = document.getElementById("eyeIcon");
            if (passwordField.type === "password") {
                passwordField.type = "text";
                eyeIcon.classList.remove("fa-eye");
                eyeIcon.classList.add("fa-eye-slash");
            } else {
                passwordField.type = "password";
                eyeIcon.classList.remove("fa-eye-slash");
                eyeIcon.classList.add("fa-eye");
            }
        }
    </script>
    <% 
    // Check if an error message is present in request attribute
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
    %>
    <script>
        // Display error message in a popup alert
        alert("<%= errorMessage %>");
    </script>
    <% } %>
</body>
</html>