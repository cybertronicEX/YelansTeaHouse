package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from request
        int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
        int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));

        // Update the quantity of the item in the cart
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = SQLConnect.connect();
            String sql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, cartItemId);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                // Quantity updated successfully
                response.sendRedirect("view_cart.jsp"); // Redirect to cart page
            } else {
                // Failed to update quantity
                response.getWriter().println("Failed to update quantity in cart.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error occurred.");
        } finally {
            SQLConnect.close(null, stmt, conn);
        }
    }
}
