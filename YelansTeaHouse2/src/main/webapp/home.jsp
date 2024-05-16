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
        <h2>Featured Brands</h2>
        <div class="featured-products">
            <!-- Featured Product 1 -->
            <div class="product1">
            	<img src="https://upload.wikimedia.org/wikipedia/en/thumb/3/37/Dilmah_logo.svg/1200px-Dilmah_logo.svg.png" alt="Dilmah">
            </div>
            <!-- Featured Product 2 -->
            <div class="product2">
            	<img src="https://www.shopalimentari.it/wp-content/uploads/2020/03/2.Twinings-Tea-1.jpg" alt="Twinings">
            </div>
            <!-- Featured Product 3 -->
            <div class="product3">
            	<img src="https://www.akbar.com/wp-content/uploads/2021/12/Akbar-Brothers.jpg" alt="Akbar">
            </div>
            <!-- Featured Product 4 -->
            <div class="product4">
            	<img src="https://m.media-amazon.com/images/S/abs-image-upload-na/d/AmazonStores/ATVPDKIKX0DER/ae532ccf68f2c0c8862bf3c936af5d5a.w400.h400.gif" alt="Yorkshire">
            </div>
        </div>
        <a href="ProductServlet"><button class="view-all-products-button">View All Products</button></a>
    </div>

	<div class="testimonial-section">
	<h2>Testimonials</h2>
	<div class="testimonials">
	    <!-- Testimonial 1 -->
	    <div class="testimonial">
	        <p>"Discovering Yelan's Tea House has been a delight! The selection of teas is unparalleled, and each order arrives fresh and full of aroma. It's like a journey around the world in every cup!"</p>
	        <span>- Alex P.</span>
	    </div>
	    <!-- Testimonial 2 -->
	    <div class="testimonial">
	        <p>"I'm a tea enthusiast, and Yelan's Tea House has become my go-to source. The website is easy to navigate, and their rare tea collections are a treasure trove for someone like me."</p>
	        <span>- Jamie L.</span>
	    </div>
	    <!-- Testimonial 3 -->
	        <div class="testimonial">
	            <p>"The quality of tea from Yelan's Tea House is exceptional. Their commitment to sustainability and the variety of organic options is impressive. Highly recommend!"</p>
	            <span>- Sam K.</span>
	        </div>
	    </div>
	</div>


    <footer>
        <p>&copy; 2024 Yelan's Tea House. All rights reserved.</p>
    </footer>
</body>
</html>
