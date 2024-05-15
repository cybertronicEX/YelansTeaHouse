package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ViewCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user ID from session or request parameters
        int userId = Integer.parseInt(request.getParameter("userId")); // Assuming userId is passed as a parameter

        // Fetch cart items for the user from the database
        List<CartItem> cartItems = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = SQLConnect.connect();
            String sql = "SELECT * FROM cart WHERE user_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int cartItemId = rs.getInt("cart_id");
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");

                // Assuming there's a method to fetch product details by product ID
                Product product = getProductById(productId);

                // Update the price attribute with casting
                if (product != null) {
                    // Convert double price to int before setting
                    int price = (int) product.getPrice();
                    product.setPrice(price);
                }

                // Create a CartItem object
                CartItem cartItem = new CartItem(cartItemId, product, quantity);
                cartItems.add(cartItem);
            }

            // Forward cart items to the view_cart.jsp page
            request.setAttribute("cartItems", cartItems);
            request.getRequestDispatcher("view_cart.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error occurred while fetching cart items.");
        } finally {
            SQLConnect.close(rs, stmt, conn);
        }
    }

    // Method to fetch product details by product ID
    private Product getProductById(int productId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Product product = null;
        try {
            conn = SQLConnect.connect();
            String sql = "SELECT * FROM products WHERE itemNo = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Assuming Product is a class representing product details
                product = new Product();
                product.setItemNo(rs.getInt("itemNo"));
                product.setItemName(rs.getString("itemName"));
                
             // Convert double to int for price
                double priceDouble = product.getPrice();
                int priceInt = (int) priceDouble; // Convert double to int
                product.setPrice(priceInt);
                product.setBrandName(rs.getString("brandName"));
                
             // Convert double to int for weight
                double weightDouble = rs.getDouble("weight");
                int weightInt = (int) weightDouble;
                product.setWeight(weightInt);
                product.setNutrition(rs.getString("nutrition"));
                product.setImageUrl(rs.getString("imageUrl"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SQLConnect.close(rs, stmt, conn);
        }
        return product;
    }
}
