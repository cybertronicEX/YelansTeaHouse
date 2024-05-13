package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemName = request.getParameter("itemName");
        int price = Integer.parseInt(request.getParameter("price"));
        String brandName = request.getParameter("brandName");
        int weight = Integer.parseInt(request.getParameter("weight"));
        String nutrition = request.getParameter("nutrition");
        String imageUrl = request.getParameter("imageUrl");

        Connection conn = SQLConnect.connect();
        try {
        	String sql = "INSERT INTO products (itemName, price, brandName, weight, nutrition, imageUrl) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, itemName);
            stmt.setInt(2, price);
            stmt.setString(3, brandName);
            stmt.setInt(4, weight);
            stmt.setString(5, nutrition);
            stmt.setString(6, imageUrl);
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                // Product added successfully
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script type='text/javascript'>");
                out.println("alert('Product Added successfully.');");
                out.println("window.location.href='ProductServlet';");
                out.println("</script>");
            } else {
                // Add Product failed
                response.getWriter().append("Add Product failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().append("Error occurred.");
        }
    }
}
