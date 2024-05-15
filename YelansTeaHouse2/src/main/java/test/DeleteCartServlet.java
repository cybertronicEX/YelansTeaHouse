package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class DeleteCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve cart item ID from request
        int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));

        // Delete the item from the cart
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = SQLConnect.connect();
            String sql = "DELETE FROM cart WHERE cart_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartItemId);
            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                // Item deleted successfully
                response.sendRedirect("view_cart.jsp"); // Redirect to cart page
            } else {
                // Failed to delete item
                response.getWriter().println("Failed to delete item from cart.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error occurred.");
        } finally {
            SQLConnect.close(null, stmt, conn);
        }
    }
}
