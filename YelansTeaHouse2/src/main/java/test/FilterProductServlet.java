package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FilterProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public FilterProductServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = SQLConnect.connect();

            // Retrieve product data from the database
            String productSql = "SELECT * FROM products WHERE brandName = ?";
            stmt = conn.prepareStatement(productSql);
            stmt.setString(1, request.getParameter("brandName"));
            rs = stmt.executeQuery();

            StringBuilder html = new StringBuilder();
            while (rs.next()) {
                html.append("<form id=\"deleteProductForm_").append(rs.getInt("itemNo")).append("\" action=\"DeleteProductServlet\" method=\"POST\">");
                html.append("<input type=\"hidden\" name=\"itemName\" value=\"").append(rs.getString("itemName")).append("\">");
                html.append("<div class=\"product-card\" onclick=\"openProductPopup('").append(rs.getString("itemName")).append("', ").append(rs.getInt("price")).append(", '").append(rs.getString("brandName")).append("', ").append(rs.getInt("weight")).append(", '").append(rs.getString("nutrition")).append("', '").append(rs.getString("imageUrl")).append("')\">");
                html.append("<img src=\"").append(rs.getString("imageUrl")).append("\" alt=\"").append(rs.getString("itemName")).append("\">");
                html.append("<div class=\"product-details\">");
                html.append("<p class=\"item-name\">").append(rs.getString("itemName")).append("</p>");
                html.append("<p class=\"price\">Rs.").append(rs.getInt("price")).append("</p>");
                html.append("<button class=\"add-to-cart-button\">Add to Cart</button>");
                html.append("</div></div></form>");
            }
            html.append("</div>");

            // Send the response
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(html.toString());

        } catch (SQLException ex) {
            ex.printStackTrace();
            // TODO: Handle exceptions
        } finally {
            // Use SQLConnect class to close resources
            SQLConnect.close(rs, stmt, conn);
        }
    }
}
