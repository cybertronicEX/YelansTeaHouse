<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <link rel="stylesheet" href="blah/style.css">
    <link rel="stylesheet" href="blah/petals.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</head>
<body>
<div class="RegisterMainContainer">
    <div id="blossom_container"></div>
    <script src="js/petals.js"></script>

    <div class="topbar d-flex flex-row align-items-center">
        <img class="img-contain p-3" src="img/logo_mini.png">
    </div>
    <div class="tree_container">
        <img class="img-contain p-3" src="imgs/tree.png">
    </div>
    <div class="form-wrap">
        <div  class="header">
            <!--title-->
            <div>
                <img class="img-contain1 p-3" src="img/logo.png">
            </div>
            <!--end title-->
        </div>
        <!--form-->
        <form action="RegistrationServlet" method="POST">
            <div class="register-form-container">
                <div class="">
                    <i class="fa fa-envelope"></i>
                    <input class="input-text" type="email" name="email" placeholder="Email address" required onchange="validatemail()">
                </div>
                <div class="">
		            <i class="fa fa-phone"></i>
		            <input class="input-text" type="text" name="contactNumber" placeholder="Contact number" required>
		        </div>
		        <div class="">
		            <i class="fa fa-home"></i>
		            <input class="input-text" type="text" name="address" placeholder="Address" required>
		        </div>
	            <div class="">
	                  <i class="fa fa-key"></i>
	                  <input class="input-text" type="password" name="password" id="password" placeholder="Password" required onchange="validatePass()">
	                <!--   <button type="button" class="eyeBtn" onclick="togglePasswordVisibility()">
	                      <i id="eyeIcon" class="fa fa-eye"></i>
	                  </button> -->
	             </div>
	              <div>
	                  <button class="btn1 btn-register" type="submit">Register</button>
	              </div>
            </div>
        </form>
        <div class="sign-in">
            <p class="bold-text">Already have an account?</p>
            <a  class="btn1 btn-login form-a"  href="login.jsp">Login</a>
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
</body>
</html>
