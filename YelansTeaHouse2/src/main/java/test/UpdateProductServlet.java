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

public class UpdateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemName = request.getParameter("itemName");
        int price = Integer.parseInt(request.getParameter("price"));
        String brandName = request.getParameter("brandName");
        int weight = Integer.parseInt(request.getParameter("weight"));
        String nutrition = request.getParameter("nutrition");
        String imageUrl = request.getParameter("imageUrl");

        boolean updated = false;
        Connection conn = SQLConnect.connect();
        try {
            String sql = "UPDATE products SET price=?, brandName=?, weight=?, nutrition=?, imageUrl=? WHERE itemName=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, price);
            stmt.setString(2, brandName);
            stmt.setInt(3, weight);
            stmt.setString(4, nutrition);
            stmt.setString(5, imageUrl);
            stmt.setString(6, itemName);
            updated = stmt.executeUpdate() > 0;
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database errors
        }

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<script type='text/javascript'>");
        if (updated) {
            out.println("alert('Product updated successfully.');");
        } else {
            out.println("alert('Failed to update product.');");
        }
        out.println("setTimeout(function(){ window.location.href='" + request.getContextPath() + "/ProductServlet'; }, 3000);");
        out.println("</script>");
    }
}
