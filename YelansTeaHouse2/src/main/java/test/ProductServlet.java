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

public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = SQLConnect.connect();

            // Retrieve product data from the database
            String productSql = "SELECT * FROM products";
            stmt = conn.prepareStatement(productSql);
            rs = stmt.executeQuery();
            List<Product> productList = new ArrayList<>();
            while (rs.next()) {
                Product product = new Product();
                product.setItemNo(rs.getInt("itemNo"));
                product.setItemName(rs.getString("itemName"));
                product.setPrice(rs.getInt("price"));
                product.setBrandName(rs.getString("brandName"));
                product.setWeight(rs.getInt("weight"));
                product.setNutrition(rs.getString("nutrition"));
                product.setImageUrl(rs.getString("imageUrl"));
                productList.add(product);
            }
            request.setAttribute("productList", productList);

            // Retrieve distinct brand names from the database
            String brandSql = "SELECT DISTINCT brandName FROM products";
            stmt = conn.prepareStatement(brandSql);
            rs = stmt.executeQuery();
            List<String> brandList = new ArrayList<>();
            while (rs.next()) {
                String brandName = rs.getString("brandName");
                brandList.add(brandName);
            }
            request.setAttribute("brandList", brandList);

            // Forward the request to the products.jsp page for display
            request.getRequestDispatcher("products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('" + e.getMessage() + "');");
            response.getWriter().println("location='products.jsp';");
            response.getWriter().println("</script>");
        } finally {
            // Close resources
            SQLConnect.close(rs, stmt, conn);
        }
    }
}
