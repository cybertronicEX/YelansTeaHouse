package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class CreateCartServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from request
        int userId = Integer.parseInt(request.getParameter("userId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Insert the product into the cart
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = SQLConnect.connect();
            String sql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                // Product added to cart successfully
                response.sendRedirect("cart.jsp"); // Redirect to cart page
            } else {
                // Failed to add product to cart
                response.getWriter().println("Failed to add product to cart.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error occurred.");
        } finally {
            SQLConnect.close(null, stmt, conn);
        }
    }
}
