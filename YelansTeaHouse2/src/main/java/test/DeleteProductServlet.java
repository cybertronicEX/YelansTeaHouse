package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class DeleteProductServlet
 */
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve product name from the form
        String itemName = request.getParameter("itemName");

        // Perform deletion
        boolean deleted = false;
        try {
            Connection conn = SQLConnect.connect();
            String query = "DELETE FROM products WHERE itemName=?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, itemName);
            deleted = statement.executeUpdate() > 0;
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database errors
        }

        // Send a response to the client with JavaScript to display an alert and redirect
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<script type=\"text/javascript\">");
        if (deleted) {
            out.println("alert('Product deleted successfully');");
        } else {
            out.println("alert('Failed to delete product');");
        }
        // Redirect after a delay of 3 seconds (3000 milliseconds)
        out.println("setTimeout(function(){ window.location.href='" + request.getContextPath() + "/ProductServlet'; }, 100);");
        out.println("</script>");
        if (deleted) {
            System.out.println("Product deleted successfully: " + itemName); // Log successful deletion
        } else {
            System.out.println("Failed to delete product: " + itemName); // Log failed deletion
        }
    }
}
