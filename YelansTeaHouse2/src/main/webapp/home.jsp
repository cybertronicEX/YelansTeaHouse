<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <link rel="stylesheet" href="blah/css/home.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>
    <div class="cover">
    	<div class="cover-image">
    		<img src="imgs/longlass.png" alt="Cover Image">
    	</div>
        <div class="overlay">
            <h1>Welcome to Yelan's Tea House!</h1>
            <p>Discover amazing blends and flavours!</p>
        </div>
    </div>

    <div class="about-section">
        <div class="about-image">
            <img src="imgs/teacups.png" alt="About Image">
        </div>
        <div class="about-text">
            <h2>About Us</h2>
            <p>Welcome to Yelan's Tea House, where tradition meets tranquillity in a cup of tea,Nestled in the heart of our community, we are a family-owned business dedicated to bringing you the finest selection of teas from around the world. Our passion for tea is steeped in history, with recipes and blends passed down through generations.
            <br>
            <br>
             At Yelan's Tea House, we believe that every sip should tell a story. Whether it's the robust flavours of our estate-grown Ceylon black tea or the delicate aroma of our hand picked jasmine blossoms, our teas are curated to provide you with an unparalleled experience.
            <br>
            <br>
              Join us on a journey of discovery and delight, as we share with you our love for the leaf that has captivated hearts and soothed souls for centuries. From our house to yours, we invite you to taste the legacy of Yelan's Tea House.</p>
        </div>
    </div>

    <div class="products-section">
        <h2>Featured Products</h2>
        <div class="featured-products">
            <!-- Featured Product 1 -->
            <div class="product"></div>
            <!-- Featured Product 2 -->
            <div class="product"></div>
            <!-- Featured Product 3 -->
            <div class="product"></div>
            <!-- Featured Product 4 -->
            <div class="product"></div>
        </div>
        <a href="ProductServlet"><button class="view-all-products-button">View All Products</button></a>
    </div>

    <div class="testemonial-section">
        <h2>Testimonials</h2>
        <div class="testemonials">
            <!-- Testimonial 1 -->
            <div class="testemonial"></div>
            <!-- Testimonial 2 -->
            <div class="testemonial"></div>
            <!-- Testimonial 3 -->
            <div class="testemonial"></div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Yelan's Tea House. All rights reserved.</p>
    </footer>
</body>
</html>
